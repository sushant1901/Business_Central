table 50104 "Employee Payment Line"
{
    DataClassification = CustomerContent;
    Caption = 'Bonus Line';
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.';
            TableRelation = "Employee Payment Header";
        }
        field(2; "Bonus Reason No."; text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
            TableRelation = "Bonus reason";

            trigger OnLookup()
            var
                emp: Record "Bonus reason";
                bonus: Decimal;
            begin
                emp.Reset();
                if Page.RunModal(Page::"Bonus Reason", emp) = Action::LookupOK then begin
                    "Bonus Reason No." := emp.Description;
                    bonus := emp."Bonus percentage";
                    Validate("Bonus Perc.", bonus);
                end;

            end;
        }

        field(3; "Bonus Perc."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Bonus Perc.';
            // MinValue = 0;
            // MaxValue = 100;
            trigger OnValidate()
            var
                empdetail: Record "Employee Payment Header";
                emp: Decimal;
            begin
                empdetail.SetRange("No.", Rec."Document No.");
                if empdetail.FindFirst() then begin
                    emp := empdetail."Amount Paid" * ("Bonus Perc." / 100);
                    Validate("Bonus Amount", emp);

                end;
            end;
        }
        field(4; "Lines Number"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Number';
        }

        field(5; "Bonus Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Bonus Amount';
            trigger OnValidate()
            var
                TotalBonusAmount: Decimal;
                EmployeePaymentLineRec: Record "Employee Payment Header";
            begin
                TotalBonusAmount := 0;
                EmployeePaymentLineRec.SetRange("No.", Rec."Document No.");
                if EmployeePaymentLineRec.FindSet() then
                    repeat
                        TotalBonusAmount += "Bonus Amount";
                    until EmployeePaymentLineRec.Next() = 0;
            end;
        }
    }
    keys
    {
        key(PK; "Document No.", "Lines Number")
        {
            Clustered = true;
        }
    }
}