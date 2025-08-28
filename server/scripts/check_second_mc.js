import { getDb } from '../src/db.js';
const db = getDb();
for (let unit=6; unit<=10; unit++){ const mc= db.prepare("SELECT id FROM questions WHERE unit_id=? AND type='mc' ORDER BY id").all(unit); if(mc.length>=2){ const second=mc[1].id; const c=db.prepare('SELECT COUNT(*) c FROM options WHERE question_id=?').get(second).c; console.log('Unit',unit,'second mc options:',c); }}
