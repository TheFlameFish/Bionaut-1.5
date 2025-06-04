class Schrumbalere : ZombieMan replaces ZombieMan {
    Default {
        Scale 0.25;
        Radius 5;
        Height 14;
        Speed 10;
        DropItem "SchrumbalereChainsaw";
    }
}

class SchrumbalereChainsaw : Chainsaw {
    default {
        Scale 2;
        Inventory.PickupMessage "Wowza yowza! A chainsaw!";
    }

    States {
        Fire:
            TNT1 A 0 A_Light2;
            SAWG AB 4 Bright A_Saw;
            SAWG B 0 A_ReFire;
            TNT1 A 0 A_Explode;
            Goto Ready;
    }
}