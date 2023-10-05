page 50111 "EmployeePaymentListPage"
{
    PageType = List;
    Caption = 'EmployeePaymentList';
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Payment Header";
    CardPageId = "Employee payment Card";
    //InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(PaymentHeader)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the serial Number';
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Employee Number';
                }
                field("Starting Date:"; Rec."Starting Date:")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of start';
                }

                field("Ending Date:"; Rec."Ending Date:")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date of End';
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    StyleExpr = StatusColor;

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


    trigger OnAfterGetRecord()

    begin
        case Rec.Status of
            Rec.Status::Released:
                StatusColor := 'Favorable';
            Rec.Status::Reopen:
                StatusColor := 'StandardAccent';
            Rec.Status::"Pending Approval":
                StatusColor := 'Ambiguous';
            Rec.Status::Draft:
                StatusColor := 'Unfavorable';
        end;
    end;

    var
        StatusColor: Text;
}