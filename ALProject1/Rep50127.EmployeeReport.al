report 50128 "Employee Information"
{
    ApplicationArea = All;
    Caption = 'Employee Information';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = 'Employee Payment.RDL';

    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(Picture; Picture)
            {
            }
            column(ContactPerson; "Contact Person")
            {
            }
            column(City; City)
            {
            }
            column(PhoneNo; "Phone No.")
            {
            }
            column(Address; Address)
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(Name; Name)
            {

            }
        }

        dataitem("Employee Payment Header"; "Employee Payment Header")
        {
            column(Employee_No; "Employee No.") { }
            column(Starting_Date; "Starting Date:") { }

            column(Ending_Date; "Ending Date:") { }
            column(Status; Status) { }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
}
