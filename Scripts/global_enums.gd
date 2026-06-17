class_name Enums

## For Actions
## Type of action. Special actions are for Overcharging and things that don't fall into any other category.
enum ActionType {QUICK, FULL, FREE, PROTOCOL, REACTION, SPECIAL}
enum ActionOwner {MECH, PILOT}

## For Events
enum Event {ATTACK, ROLL_DAMAGE, HIT, CRIT, MISS, MOVE, BOOST, PICKING_TARGET, TARGET_PICKED, TAKE_DAMAGE, TAKE_ACTION, TAKE_PROTOCOL}
enum Stat {HP, HEAT, STRUCTURE, STRESS, SPEED, MAX_SPEED}
enum Targets {SELF, ALLY, ENEMY, OBJECT}
enum Expires {END_TURN, END_ROUND, START_NEXT_TURN_SELF, END_NEXT_TURN_SELF, END_NEXT_TURN_ENEMY, END_SCENE}

## For Weapons and systems.
enum MountType {AUX, MAIN, HEAVY, SUPERHEAVY}
enum WeaponType {SPECIAL, CQB, CANNON, LAUNCHER, MELEE, NEXUS, RIFLE}
enum RangeType {BLAST, BURST, CONE, LINE, RANGE, THREAT}
enum DamageType {BURN, ENERGY, EXPLOSIVE, HEAT, KINETIC}
enum StatusCode {DESTROYED, USED, MOVED}
