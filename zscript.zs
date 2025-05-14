version "4.14.1"

class NewZombie : ZombieMan replaces ZombieMan {
    Default {
        Scale 0.25;
        DropItem "Chainsaw";
    }
}

class NewChainsaw : Chainsaw replaces Chainsaw {
    default {
        Scale 2;
    }
}