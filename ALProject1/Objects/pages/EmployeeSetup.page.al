page 50110 "EmployeeSetupPage"
{
    PageType = List;
    Caption = 'SetUp';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Setup";
    Editable = false;
    // CardPageId = "Employee Setup ";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Employee Setup';
                }
                field("Employee Nos."; Rec."Employee Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Employee Number';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}