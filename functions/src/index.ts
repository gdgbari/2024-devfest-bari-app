require('module-alias/register');

import { Group } from '@modelsGroup';
import { Question } from '@modelsQuestion';
import { Quiz } from '@modelsQuiz';
import { QuizResult } from '@modelsQuizResult';
import { Sponsor } from '@modelsSponsor';
import { Talk } from '@modelsTalk';
import { UserProfile } from '@modelsUserProfile';
import * as admin from 'firebase-admin';
import { DocumentReference, Timestamp } from 'firebase-admin/firestore';
import * as functions from 'firebase-functions';

admin.initializeApp();

const db = admin.firestore();

// Authentication section

async function parseGroupRef(groupRef: DocumentReference): Promise<Group> {
    const groupDoc = await groupRef.get();

    if (!groupDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'Group not found.');
    }

    const groupData = groupDoc.data();

    if (!groupData) {
        throw new functions.https.HttpsError('not-found', 'Group data not found.');
    }

    const group: Group = {
        groupId: groupDoc.id,
        name: groupData.name,
        imageUrl: groupData.imageUrl
    }

    return group;
}

export const getUserProfile = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    try {
        const userDoc = await db.collection('users').doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'User not found.');
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError('not-found', 'User data not found.');
        }

        const group: Group = await parseGroupRef(userData.group);

        const userProfile: UserProfile = {
            userId: userDoc.id,
            email: userData.email,
            name: userData.name,
            surname: userData.surname,
            group: group
        };

        return JSON.stringify(userProfile)
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the user.', error);
    }
});

// Quiz section

async function parseQuestionListRef(questionListRef: DocumentReference[], hideData: boolean): Promise<Question[]> {
    const questionList: Question[] = await Promise.all(
        questionListRef.map(async questionRef => {
            const questionDoc = await questionRef.get();

            if (!questionDoc.exists) {
                throw new Error('Question not found');
            }

            const questionData = questionDoc.data();

            if (!questionData) {
                throw new Error('Question not found');
            }

            return {
                questionId: questionDoc.id,
                text: questionData.text,
                answerList: questionData.answerList,
                correctAnswer: !hideData ? questionData.correctAnswer : null,
                value: !hideData ? questionData.value : null
            } as Question;
        })
    );

    return questionList;
}

export const getQuiz = functions.https.onCall(async (data, context) => {
    const { quizId } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    if (!quizId) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid quizId.');
    }

    try {
        const quizDoc = await db.collection('quizzes').doc(quizId).get();

        if (!quizDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Quiz not found.');
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        const questionList: Question[] = await parseQuestionListRef(quizData.questionList, true);

        const quiz: Quiz = {
            quizId: quizDoc.id,
            type: quizData.type,
            talkId: quizData.talkId,
            sponsorId: quizData.sponsorId,
            maxScore: quizData.maxScore,
            isOpen: null,
            questionList: questionList,
        };

        return JSON.stringify(quiz);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the quiz.', error);
    }
});

export const submitQuiz = functions.https.onCall(async (data, context) => {
    const { quizId, answerList } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    const uid = context.auth.uid;

    if (!quizId || !Array.isArray(answerList)) {
        throw new functions.https.HttpsError('invalid-argument', 'The function must be called with a valid quizId and answerList.');
    }

    try {
        const quizDoc = await db.collection('quizzes').doc(quizId).get();

        if (!quizDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'Quiz not found.');
        }

        const quizData = quizDoc.data();

        if (!quizData || !quizData.isOpen) {
            throw new functions.https.HttpsError('failed-precondition', 'Quiz is not open.');
        }

        const answerDoc = await db.collection('users').doc(uid).collection('quizzes').doc(quizId).get();

        if (answerDoc.exists) {
            throw new functions.https.HttpsError('already-exists', 'Quiz already submitted.');
        }

        let score = 0;
        const maxScore = quizData.maxScore;

        if (answerList.length !== quizData.questionList.length) {
            throw new functions.https.HttpsError('invalid-argument', 'The answerList must have the same length as the questionList.');
        }

        const questionList: Question[] = await parseQuestionListRef(quizData.questionList, false);

        questionList.forEach((question: Question, index: number) => {
            if (question.correctAnswer === answerList[index]) {
                score += question.value || 0;
            }
        });

        const result: QuizResult = { score, maxScore };

        await db.collection('users').doc(uid).collection('quizzes').doc(quizId).set(result);

        return JSON.stringify(result);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while submitting the quiz answers.', error);
    }
});

// Talk section

export const createTalk = functions.https.onCall(async (data, context) => {
    const { title, description, track, room, startTime, endTime } = data;

    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    try {
        const userDoc = await db.collection('users').doc(context.auth.uid).get();

        if (!userDoc.exists) {
            throw new functions.https.HttpsError('not-found', 'User not found.');
        }

        const userData = userDoc.data();

        if (!userData) {
            throw new functions.https.HttpsError('not-found', 'User data not found.');
        }

        if (userData.role != 'staff') {
            throw new functions.https.HttpsError('permission-denied', 'User not authorized.');
        }

        const talksRef = db.collection('talks');

        const talkDoc = await talksRef.add({
            title: title ?? '',
            description: description ?? '',
            track: track ?? '',
            room: room ?? '',
            startTime: Timestamp.fromMillis(startTime ?? 0),
            endTime: Timestamp.fromMillis(endTime ?? 0)
        });

        return JSON.stringify({ talkId: talkDoc.id });
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while creating the talk.', error);
    }
});

export const getTalkList = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    try {
        const talksSnapshot = await db.collection('talks').get();

        if (!talksSnapshot) {
            throw new functions.https.HttpsError('not-found', 'Talks not found.');
        }

        const talkList = await Promise.all(
            talksSnapshot.docs.map(
                async talkDoc => {
                    const talkData = talkDoc.data();

                    const talk: Talk = {
                        talkId: talkDoc.id,
                        title: talkData.title,
                        description: talkData.description,
                        track: talkData.track,
                        room: talkData.room,
                        startTime: talkData.startTime.toMillis(),
                        endTime: talkData.endTime.toMillis(),
                    }

                    return talk;
                }
            )
        );

        return JSON.stringify(talkList);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the talk quiz.', error);
    }
});

// Sponsor section

export const getSponsorList = functions.https.onCall(async (_, context) => {
    if (!context.auth) {
        throw new functions.https.HttpsError('unauthenticated', 'User must be authenticated.');
    }

    try {
        const sponsorsSnapshot = await db.collection('sponsors').get();

        if (!sponsorsSnapshot) {
            throw new functions.https.HttpsError('not-found', 'Sponsors not found.');
        }

        const sponsorList = await Promise.all(
            sponsorsSnapshot.docs.map(
                async sponsorDoc => {
                    const sponsorData = sponsorDoc.data();

                    const sponsor: Sponsor = {
                        sponsorId: sponsorDoc.id,
                        name: sponsorData.name,
                        description: sponsorData.description,
                        websiteUrl: sponsorData.websiteUrl
                    }

                    return sponsor;
                }
            )
        );

        return JSON.stringify(sponsorList);
    } catch (error) {
        throw new functions.https.HttpsError('internal', 'An error occurred while fetching the talk quiz.', error);
    }
});