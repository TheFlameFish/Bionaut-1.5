class LaundryMachine:Actor
{
    Default
    {
        Health 100;
        Radius 20;
        Height 50;
        Speed 12;
        Monster;
    }
    States
    {
        Spawn:
            TROO AB 10 A_lookEx(label: "Awaken");
            loop;
        Awaken:
            TROO A 50 A_StartSound("LaundryAlarm");
            goto Rush;
        Rush:
            TROO AB 1 A_Chase();
            loop;
    }
}