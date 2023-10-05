page 50115 "Employee Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Employee Setup";

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Employee Payment No."; Rec."Employee Nos.")
                {
                    ApplicationArea = All;

                }
                field("Workflow user group"; Rec."Workflow user group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Employee WorkFlow';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}