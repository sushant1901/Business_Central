tableextension 50121 EmployeeExt extends Employee
{
    fields
    {
        field(50114; "Is OutSourcing"; boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50115; "Amount Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    var
        myInt: Integer;
}