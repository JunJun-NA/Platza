const fs = require('fs');
const path = require('path');
const {
  initializeTestEnvironment,
  assertFails,
  assertSucceeds,
} = require('@firebase/rules-unit-testing');
const { doc, getDoc, setDoc } = require('firebase/firestore');

let testEnv;

const RULES_PATH = path.resolve(__dirname, '../../../firestore.rules');

beforeAll(async () => {
  testEnv = await initializeTestEnvironment({
    projectId: 'demo-platza',
    firestore: {
      rules: fs.readFileSync(RULES_PATH, 'utf8'),
    },
  });
});

afterAll(async () => {
  if (testEnv) {
    await testEnv.cleanup();
  }
});

beforeEach(async () => {
  await testEnv.clearFirestore();
});

const profile = (uid, overrides = {}) => ({
  uid,
  isAnonymous: true,
  createdAt: new Date(),
  updatedAt: new Date(),
  ...overrides,
});

const plant = (overrides = {}) => ({
  id: 'plant1',
  nickname: 'たろう',
  speciesId: 'echeveria_elegans',
  location: 'indoor',
  status: 'happy',
  growthStage: 'seedling',
  createdAt: new Date(),
  streakDays: 0,
  ...overrides,
});

const careLog = (overrides = {}) => ({
  id: 'log1',
  plantId: 'plant1',
  careType: 'water',
  performedAt: new Date(),
  ...overrides,
});

const careSchedule = (overrides = {}) => ({
  id: 'sch1',
  plantId: 'plant1',
  careType: 'water',
  intervalDays: 7,
  nextDueDate: new Date(),
  isEnabled: true,
  ...overrides,
});

const plantPhoto = (overrides = {}) => ({
  id: 'photo1',
  plantId: 'plant1',
  storagePath: 'users/alice/plant_photos/photo1.jpg',
  createdAt: new Date(),
  ...overrides,
});

const userSettings = (overrides = {}) => ({
  notificationEnabled: true,
  waterReminderHour: 8,
  waterReminderMinute: 0,
  fertilizerReminderEnabled: true,
  isDarkMode: false,
  updatedAt: new Date(),
  ...overrides,
});

const speciesDoc = (overrides = {}) => ({
  id: 'echeveria_elegans',
  name: 'エケベリア・エレガンス',
  category: 'succulent',
  waterFrequencyDays: 14,
  fertilizerFrequencyDays: 30,
  repotFrequencyDays: 365,
  sunlightNeed: 'medium',
  winterCare: '霜に弱いので室内へ',
  summerCare: '直射日光を避ける',
  description: '人気のロゼット型多肉植物',
  assetPrefix: 'echeveria_elegans',
  ...overrides,
});

describe('users/{uid}', () => {
  test('未認証ユーザーは読めない', async () => {
    const guest = testEnv.unauthenticatedContext().firestore();
    await assertFails(getDoc(doc(guest, 'users/alice')));
  });

  test('オーナーは自分のプロフィールを R/W できる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(setDoc(doc(alice, 'users/alice'), profile('alice')));
    await assertSucceeds(getDoc(doc(alice, 'users/alice')));
  });

  test('他人のプロフィールには R/W できない', async () => {
    await testEnv.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'users/alice'), profile('alice'));
    });
    const bob = testEnv.authenticatedContext('bob').firestore();
    await assertFails(getDoc(doc(bob, 'users/alice')));
    await assertFails(
      setDoc(doc(bob, 'users/alice'), profile('alice', { displayName: 'hack' })),
    );
  });
});

describe('users/{uid}/plants/{plantId}', () => {
  test('オーナーは自分の植物を R/W できる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(
      setDoc(doc(alice, 'users/alice/plants/plant1'), plant()),
    );
    await assertSucceeds(getDoc(doc(alice, 'users/alice/plants/plant1')));
  });

  test('他人の植物は R/W 不可', async () => {
    await testEnv.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(doc(ctx.firestore(), 'users/alice/plants/plant1'), plant());
    });
    const bob = testEnv.authenticatedContext('bob').firestore();
    await assertFails(getDoc(doc(bob, 'users/alice/plants/plant1')));
    await assertFails(setDoc(doc(bob, 'users/alice/plants/plant1'), plant()));
  });

  test('未認証は R/W 不可', async () => {
    const guest = testEnv.unauthenticatedContext().firestore();
    await assertFails(setDoc(doc(guest, 'users/alice/plants/plant1'), plant()));
  });
});

describe('users/{uid}/care_logs/{careLogId}', () => {
  test('オーナーは自分のお世話履歴を R/W できる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(
      setDoc(doc(alice, 'users/alice/care_logs/log1'), careLog()),
    );
  });

  test('他人のお世話履歴には書き込めない', async () => {
    const bob = testEnv.authenticatedContext('bob').firestore();
    await assertFails(
      setDoc(doc(bob, 'users/alice/care_logs/log1'), careLog()),
    );
  });
});

describe('users/{uid}/care_schedules/{scheduleId}', () => {
  test('オーナーはスケジュールを R/W できる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(
      setDoc(doc(alice, 'users/alice/care_schedules/sch1'), careSchedule()),
    );
  });

  test('他人のスケジュールには R/W 不可', async () => {
    await testEnv.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(
        doc(ctx.firestore(), 'users/alice/care_schedules/sch1'),
        careSchedule(),
      );
    });
    const bob = testEnv.authenticatedContext('bob').firestore();
    await assertFails(getDoc(doc(bob, 'users/alice/care_schedules/sch1')));
  });
});

describe('users/{uid}/plant_photos/{photoId}', () => {
  test('オーナーは写真メタデータを R/W できる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(
      setDoc(doc(alice, 'users/alice/plant_photos/photo1'), plantPhoto()),
    );
  });

  test('他人の写真メタデータは R/W 不可', async () => {
    await testEnv.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(
        doc(ctx.firestore(), 'users/alice/plant_photos/photo1'),
        plantPhoto(),
      );
    });
    const bob = testEnv.authenticatedContext('bob').firestore();
    await assertFails(getDoc(doc(bob, 'users/alice/plant_photos/photo1')));
  });
});

describe('users/{uid}/settings/app', () => {
  test('オーナーは設定を R/W できる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(
      setDoc(doc(alice, 'users/alice/settings/app'), userSettings()),
    );
    await assertSucceeds(getDoc(doc(alice, 'users/alice/settings/app')));
  });

  test('他人の設定は R/W 不可', async () => {
    const bob = testEnv.authenticatedContext('bob').firestore();
    await assertFails(
      setDoc(doc(bob, 'users/alice/settings/app'), userSettings()),
    );
  });
});

describe('species/{speciesId}', () => {
  beforeEach(async () => {
    await testEnv.withSecurityRulesDisabled(async (ctx) => {
      await setDoc(
        doc(ctx.firestore(), 'species/echeveria_elegans'),
        speciesDoc(),
      );
    });
  });

  test('未認証ユーザーは読み取れない', async () => {
    const guest = testEnv.unauthenticatedContext().firestore();
    await assertFails(getDoc(doc(guest, 'species/echeveria_elegans')));
  });

  test('認証ユーザーは読み取れる', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertSucceeds(getDoc(doc(alice, 'species/echeveria_elegans')));
  });

  test('認証ユーザーでも書き込めない', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertFails(
      setDoc(doc(alice, 'species/new_species'), speciesDoc({ id: 'new_species' })),
    );
  });
});

describe('未定義パス', () => {
  test('認証ありでも全拒否', async () => {
    const alice = testEnv.authenticatedContext('alice').firestore();
    await assertFails(getDoc(doc(alice, 'random/x')));
    await assertFails(setDoc(doc(alice, 'random/x'), { foo: 'bar' }));
  });
});
