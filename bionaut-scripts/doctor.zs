#include "bionaut-scripts/projectiles.zs"

class Doctor : Actor
{
	Default
	{
		Health 60;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 0;
		Monster;
		+FLOORCLIP
		SeeSound "grunt/sight";
		AttackSound "grunt/attack";
		PainSound "grunt/pain";
		DeathSound "grunt/death";
		ActiveSound "grunt/active";
		Obituary "$OB_ZOMBIE";
		Tag "Doctor";
		DropItem "Clip";
	}

	virtual void A_DoctorAttack() {
		A_CustomComboAttack("BionautFireball", 32, 3 * random(1, 8), "imp/melee");
	}

 	States
	{
	Spawn:
		DOCT IO 15 A_Look(); // AB
		Loop;
	See:
		DOCT AB 4 A_Chase();
		Loop;
	Missile:
		DOCT E 10 A_FaceTarget();
        TNT1 A 0 A_Light2();
		DOCT F 8 Bright A_DoctorAttack();
        TNT1 A 0 A_Light0();
		DOCT E 8;
		Goto See;
	Pain:
		POSS G 3;
		POSS G 3 A_Pain();
		Goto See;
	Death:
		HART A 10 A_Scream();
		HART B 10;
		HART C 10 A_NoBlocking();
		HART DEFG 10;
		HART H -1;
		Stop;
	XDeath:
		goto Death;
	Raise:
		HART H 1;
        HART GFEDCBA 5;
		Goto See;
	}
}

class FlameDoctor : Doctor {
	override void A_DoctorAttack() {
		for (int i = 10; i > 0; i--)
		{
			//A_CustomComboAttack("FlameWisp", 32, 3 * random(1, 8), "imp/melee");
			A_SpawnProjectile("FlameWisp", Random(20, 40), 0, Random(-15, 15));
		}
	}

	States {
		Missile:
			DOCT E 10 A_FaceTarget();
			TNT1 A 0 A_Light2();
			DOCT FF 4 Bright A_DoctorAttack();
			TNT1 A 0 A_Light0();
			DOCT E 8;
			Goto See;
	}
}