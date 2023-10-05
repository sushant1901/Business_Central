pageextension 50123 "Employee List Ext" extends "Employee List"
{
    actions
    {
        addafter("E&mployee")
        {

            action("Payment Details")
            {
                ApplicationArea = all;
                Image = Payment;
                // RunObject = Page "EmployeePaymentListPage";
                trigger OnAction()
                var
                    EmployeeRec: Record "Employee Payment Header";
                    EmployeeID: Code[20];
                    EPayListPage: Page "Employee Payment Line";
                begin
                    EmployeeRec.SETRANGE("Employee No.", Rec."No.");
                    if EmployeeRec.FINDSET then begin
                        EmployeeID := EmployeeRec."No.";
                        EPayListPage.SetTableView(EmployeeRec);
                        EPayListPage.SetRecord(EmployeeRec);
                        EPayListPage.Run();
                    end
                    else begin
                        Error('No Payment Information');
                    end;
                end;



            }


        }
    }
}

