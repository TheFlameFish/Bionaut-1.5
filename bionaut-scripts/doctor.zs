class Doctor : Actor
{
	Default
	{
		Health 20;
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
 	States
	{
	Spawn:
		DOCT IO 15 A_Look; // AB
		Loop;
	See:
		DOCT AB 4 A_Chase;
		Loop;
	Missile:
		DOCT E 10 A_FaceTarget;
        TNT1 A 0 A_Light2;
		DOCT F 8 Bright A_PosAttack;
        TNT1 A 0 A_Light0;
		DOCT E 8;
		Goto See;
	Pain:
		POSS G 3;
		POSS G 3 A_Pain;
		Goto See;
	Death:
		HART A 5;
		HART B 5 A_Scream;
		HART C 5 A_NoBlocking;
		HART DEFG 5;
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