class ManaWeapon : Weapon {
    float manaMax;
    property manaMax : manaMax;
    float manaAmount;

    Default {
        self.manaMax 100;
        Weapon.AmmoUse 1;
        Weapon.AmmoType "ManaAmmo";
    }

    override void Tick() {
        super.Tick();
        if (manaAmount < manaMax) {
                A_GiveInventory("ManaAmmo", 1);
                manaAmount++;
        }
    }

    States {
        Ready:
            TNT1 A 1;
            loop;
        Deselect:
            TNT1 A 1;
            loop;
        Select:
            TNT1 A 1;
            loop;
        Spawn:
            #### # 0 {
                // invoker.manaAmount = invoker.manaMax;
                // A_GiveInventory("ManaAmmo", 1);
            }
            stop;
        Fire:
            TNT1 A 0 {
                invoker.manaAmount--;
            }
            goto Ready;
    }
}

class ManaAmmo : Ammo
{
    Default
    {
        Inventory.Icon "SHELA0";
        Inventory.MaxAmount  100;
    }
}

class ManaTest : ManaWeapon {
    Default
	{
		Weapon.SelectionOrder 1300;
        Weapon.SlotNumber 4;
		Inventory.PickupMessage "$GOTSHOTGUN";
		Obituary "$OB_MPSHOTGUN";
		Tag "$TAG_SHOTGUN";
	}

    States {
        Ready:
		SHTG A 1 A_WeaponReady;
		Loop;
	Deselect:
		SHTG A 1 A_Lower;
		Loop;
	Select:
		SHTG A 1 A_Raise;
		Loop;
	Fire:
		SHTG A 3;
		SHTG A 7 A_FireShotgun;
		SHTG BC 5;
		SHTG D 4;
		SHTG CB 5;
		SHTG A 3;
		SHTG A 7 A_ReFire;
        TNT1 A 0
        {
            invoker.manaAmount--;
        }
        goto Ready;  // jump to ManaTest’s Ready
    Flash:
		SHTF A 4 Bright A_Light1;
		SHTF B 3 Bright A_Light2;
		Goto LightDone;
    Spawn:
        SHOT A -1;
        goto super::Spawn;
    }
}