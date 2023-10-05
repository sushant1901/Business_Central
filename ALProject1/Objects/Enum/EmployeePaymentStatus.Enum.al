enum 50100 "Emplyee Bonus Status"
{
    Extensible = true;

    value(0; "Draft")
    {
        Caption = 'Draft';
    }
    value(10; "Released")
    {
        Caption = 'released';
    }
    value(20; "Reopen")
    {
        Caption = 'Reopen';
    }
    value(30; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
}