table 50100 "Employee Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'Employee Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "Employee Nos."; Code[20])
        {
            Caption = 'Employee Nos';
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
        }
        field(3; "Workflow user group"; Code[20])
        {
            Caption = 'Employee WorkFlow';
            TableRelation = "Workflow user group";

        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}