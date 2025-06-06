#include "bionaut-scripts/mana-weapon.zs"

class FireballWeapon : ManaWeapon {
    Default
    {
        ManaWeapon.ManaUse 50;
        ManaWeapon.ManaRate 10;
        Weapon.SelectionOrder 1300;
        Weapon.SlotNumber 2;
        Inventory.PickupMessage "$GOTSHOTGUN";
        Obituary "$OB_MPSHOTGUN";
        Tag "$TAG_SHOTGUN";
    }

    States {
    Ready:
        tnt1 A 0;
        CAST A 1 A_WeaponReady;
        Loop;
    Deselect:
        CAST A 1 A_Lower;
        Loop;
    Select:
        CAST A 1 A_Raise;
        Loop;
    Fire:
        TNT1 A 0 A_CheckMana();
        TNT1 A 0 Bright 
        {
            A_Recoil(0.5);
            vel.z += 0.75;
            A_DepleteMana();
        }
        CAST A 10 Bright A_FireProjectile("BionautFireball");
        TNT1 A 0 A_ReFire;
        Goto Ready;
    Flash:
        Goto LightDone;
    Spawn:
        SHOT A -1;
        goto super::Spawn;
    }
}