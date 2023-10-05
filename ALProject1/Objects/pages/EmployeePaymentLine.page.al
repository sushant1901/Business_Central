page 50147 "Employee Payment Line"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Payment Header";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date:"; Rec."Starting Date:")
                {
                    ApplicationArea = All;
                }
                field("Ending Date:"; Rec."Ending Date:")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            { ApplicationArea = All; trigger OnAction(); begin end; }
        }
    }
}

