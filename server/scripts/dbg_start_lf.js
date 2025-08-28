import { startQuiz } from '../src/services/quizzes.js';
const quiz=startQuiz(null,{scope:'lf',scopeRef:1001,num:100});
const target=quiz.questions.find(q=>q.stem.startsWith('Teilzeit ändert das Ausbildungsziel'));
console.log('Gefundene Frage:',target);
