class ManaWeapon : Weapon {
    double manaMax;
    property manaMax : manaMax;
    double manaUse;
    property manaUse : manaUse;
    double manaRate;
    property manaRate : manaRate;
    double manaAmount;

    Default {
        self.manaMax 100;
        self.manaUse 1;
        self.manaRate 1;
        Weapon.AmmoUse 0; // Hacky way of making Doom not switch weapons when player runs out of mana. Use manaUse
        Weapon.AmmoType "ManaAmmo";
        +WEAPON.NOAUTOFIRE
    }

    override void DoEffect() {
        super.DoEffect();
        if (manaAmount <= manaMax) {
                // Set amount of ammo in inventory to display on HUD
                owner.A_SetInventory("ManaAmmo", int(Ceil(manaAmount)));
                manaAmount+= manaRate * (1.0/35.0);
                // Console.printf("Mana %f", manaAmount);
        }
    }

    action state A_CheckMana() {
        // Somewhat copy-pasted from A_Refire :p
        if (NULL == player)
        {
            return ResolveState(Null);
        }
        if (invoker.manaAmount < invoker.manaUse) {
            player.refire = 0;
            return ResolveState("Ready");
        }
        return ResolveState(null);
    }

    action void A_DepleteMana() {
        invoker.manaAmount -= invoker.manaUse;
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
            tnt1 A 0;
            stop;
        Fire:
            TNT1 A 0 A_CheckMana();
            TNT1 A 0 A_DepleteMana();
            goto Ready;
    }
}

// Serves no purpose other than HUD display.
// Amount is directly set by weapons.
class ManaAmmo : Ammo
{
    Default
    {
        Inventory.Icon "SHELA0";
        Inventory.MaxAmount  1e6;
    }
}

class ManaTest : ManaWeapon {
    Default
    {
        ManaWeapon.ManaUse 5;
        ManaWeapon.ManaRate 10;
        Weapon.SelectionOrder 1300;
        Weapon.SlotNumber 4;
        Inventory.PickupMessage "$GOTSHOTGUN";
        Obituary "$OB_MPSHOTGUN";
        Tag "$TAG_SHOTGUN";
    }

    States {
    Ready:
        tnt1 A 0;
        SHTG A 1 A_WeaponReady;
        Loop;
    Deselect:
        SHTG A 1 A_Lower;
        Loop;
    Select:
        SHTG A 1 A_Raise;
        Loop;
    Fire:
        TNT1 A 0 A_CheckMana();
        TNT1 A 0 Bright 
        {
            A_Recoil(0.5);
            vel.z += 0.75;
            A_DepleteMana();
        }
        SHTG A 1 Bright A_FireShotgun;
        SHTG A 0 A_ReFire;
        Goto Ready;
    Flash:
        SHTF A 4 Bright A_Light1;
        SHTF B 3 Bright A_Light2;
        Goto LightDone;
    Spawn:
        SHOT A -1;
        goto super::Spawn;
    }
}