pageextension 50122 "EmployeeCardExt" extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
        addafter("Job Title")
        {
            field("Is OutSourcing"; Rec."Is OutSourcing")
            {
                ApplicationArea = All;

            }


        }
        moveafter("Phone No.2"; "Gender")
        addafter("Job Title")
        {

            field("Amount Per Hour"; Rec."Amount per Hour")
            {
                ApplicationArea = all;
            }
        }




    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}