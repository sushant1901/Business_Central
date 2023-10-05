table 50101 "Employee Payment Header"
{
    DataClassification = ToBeClassified;
    // Caption = 'Employee Payment Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(5; "Employee Name"; Text[20])
        {
            DataClassification = ToBeClassified;
            caption = 'Employee Name';
        }

        field(6; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Employee No.';
            TableRelation = Employee;
            trigger OnValidate()
            var
                employee_Rec: Record Employee;
            begin
                employee_Rec.SetRange("No.", rec."Employee No.");
                if employee_Rec.FindFirst() then
                    Rec."Employee Name" := employee_Rec."First Name"
                else
                    Error('Employee Does not exists');
            end;


        }

        field(7; "Starting Date:"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Starting Date';

            trigger OnValidate()
            var
                hrsSpent: decimal;
            begin
                if "Ending Date:" <> 0D then begin
                    if "Starting Date:" < "Ending Date:" then begin
                        hrsSpent := ("Ending Date:" - "Starting Date:") * 8;
                        Validate("Hour Spent", hrsSpent);
                    end
                    else begin
                        Error('Ending date should be greater than starting date');
                    end;
                end;

            end;

        }
        field(8; "Ending Date:"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ending Date';

            trigger OnValidate()
            var
                hrsSpent: decimal;
            begin
                if "Starting Date:" <> 0D then begin
                    if "Ending Date:" > "Starting Date:" then begin
                        hrsSpent := ("Ending Date:" - "Starting Date:") * 8;
                        Validate("Hour Spent", hrsSpent);
                    end
                    else begin
                        Error('Starting date should be smaller than ending date');
                    end;
                end;

            end;



        }
        field(9; "No.series"; code[20])
        {
            caption = 'No.series';
        }

        field(10; "Hour Spent"; Decimal)
        {
            caption = 'Total Hours Spent';
            Editable = false;

            trigger OnValidate()
            var
                emodetail: Record Employee;
                Amt: Decimal;
            begin
                emodetail.SetRange("No.", Rec."Employee No.");
                if emodetail.FindFirst() then begin
                    //emodetail.TestField("Amount Per Hour");
                    if emodetail."Amount Per Hour" = 0 then Error('Amount per hour is mandatory for employee %1', emodetail."First Name");
                    Amt := "Hour Spent" * emodetail."Amount per hour";
                    Validate("Amount Paid", Amt);
                end;
            end;

        }

        field(11; "Amount Paid"; Decimal)
        {
            Caption = 'Total amount paid';
            Editable = false;

            // trigger OnValidate()
            // var
            //     EmployeeRec: Record Employee;
            //     TotalHrsSpent: Decimal;
            //     AmountPerHour: Decimal;
            //     AmountToBePaid: Decimal;

            // begin
            //     if EmployeeRec.Get("Employee No.") then begin
            //         TotalHrsSpent := Rec."Hour Spent";
            //         AmountPerHour := EmployeeRec."Amount Per Hour";
            //         AmountToBePaid := TotalHrsSpent * AmountPerHour;
            //         Message('%1', AmountToBePaid);
            //     end;
            // end;

            trigger OnValidate()
            var
                TotalBonusAmount: Decimal;
                EmployeePaymentLineRec: Record "Employee Payment Line";
            begin
                TotalBonusAmount := 0;
                EmployeePaymentLineRec.SetRange("Document No.", Rec."No.");
                if EmployeePaymentLineRec.FindSet()
                then
                    repeat
                        TotalBonusAmount += EmployeePaymentLineRec."Bonus Amount";
                    until EmployeePaymentLineRec.Next() = 0;
                Rec."Total Amount to be paid" := Rec."Amount paid" + TotalBonusAmount;
            end;

        }

        field(12; "Total Amount to be paid"; Decimal)
        {
            DataClassification = ToBeClassified;

        }

        field(13; "Status"; Enum "Emplyee Bonus Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.", "No.series")
        {
            Clustered = true;
        }


    }
    trigger OnInsert()
    var
        Noseries_cu: Codeunit NoSeriesManagement;
        EmployeSetup_rec: Record "Employee Setup";
    begin
        if "No." = '' then begin
            EmployeSetup_rec.Get();
            Noseries_cu.InitSeries(EmployeSetup_rec."Employee Nos.", xRec."No.series", Today, "No.", "No.series");
        end;
    end;

}