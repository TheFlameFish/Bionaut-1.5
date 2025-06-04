class Schrumbalere : ZombieMan replaces ZombieMan {
    bool screemblin;

    Default {
        YScale 0.5;
        Radius 5;
        Height 14;
        Speed 20;
        // DropItem "SchrumbalereChainsaw";
    }

    override void Tick() {
        super.Tick();

        if (GetAge() % 32*4 == 0) {
            self.screemblin = Random(0,5) == 1;

            if (Health <= 0) {
                self.screemblin = false;
            }
        }

        if (screemblin) {
            A_ChangeVelocity(Random(-10,10),Random(-10,10),Random(-5,5));
        }
    }

    States {
        Spawn:
            POSS AB 1 {
                self.screemblin = false;
                if (Random(0,32) == 1) {
                    A_Look();
                }
                A_Chase();
                A_ChangeVelocity(Random(-10,10),Random(-10,10),Random(-5,5));
            }
		    Loop;
        Death:
            #### # 0 A_NoBlocking();
            #### # 5 A_SetScale(1,0.6);
            #### # 5 A_SetScale(1,0.65);
            #### # 5 A_SetScale(1,0.7);
            #### # 5 A_SetScale(1,0.75);
            #### # 5 A_SetScale(1,0.8);
            #### # 5 A_SetScale(1,0.85);
            #### # 5 A_SetScale(1,0.9);
            #### # 5 A_SetScale(1,0.95);
            #### # 5 A_SetScale(1,1.0);
            #### # 5 A_SetScale(1,0.95);
            #### # 5 A_SetScale(1,0.9);
            #### # 5 A_SetScale(1,0.85);
            #### # 5 A_SetScale(1,0.8);
            #### # 5 A_SetScale(1,0.75);
            #### # 5 A_SetScale(1,0.7);
            #### # 5 A_SetScale(1,0.65);
            #### # 5 A_SetScale(1,0.6);
            #### # 5 A_SetScale(1,0.55);
            #### # 5 A_SetScale(1,0.5);
            #### # 5 A_SetScale(1,0.45);
            #### # 5 A_SetScale(1,0.4);
            #### # 5 A_SetScale(1,0.35);
            #### # 5 A_SetScale(1,0.3);
            #### # 5 A_SetScale(1,0.25);
            #### # 5 A_SetScale(1,0.2);
            #### # 5 A_SetScale(1,0.15);
            #### # 5 A_SetScale(1,0.1);
            #### # -1 {
                A_SetScale(1,1);
                A_Explode();
                A_ChangeVelocity(0,0,50);
                A_DropItem("SchrumbalereChainsaw");
                return ResolveState("XDeath");
            }
            stop;
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