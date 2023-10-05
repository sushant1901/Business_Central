table 50102 "Bonus reason"
{
    DataClassification = ToBeClassified;
    Caption = 'reason';
    fields
    {
        field(1; "SI No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
        }
        field(2; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'description of reason';
        }

        field(3; "Bonus percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'percentage';
        }

        field(4; "Active"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "SI No.")
        {
            Clustered = true;
        }
    }

}