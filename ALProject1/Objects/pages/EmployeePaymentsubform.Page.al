page 50124 "Employee Payment Subform"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Payment Line";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater("Payment Subform")
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Document number of Employee';

                }
                field("Lines Number"; Rec."Lines Number")
                {
                    ApplicationArea = all;
                    ToolTip = 'Lines Number';
                }
                field("Bonus Reason No."; Rec."Bonus Reason No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Bonus Reason Number';
                }
                field("Bonus Perc."; Rec."Bonus Perc.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Bonus %';
                }

                field("Bonus Amount"; Rec."Bonus Amount")
                {
                    ApplicationArea = all;
                    ToolTip = 'Amount to be paid as bonus';
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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}