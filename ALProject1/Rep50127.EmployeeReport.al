report 50127 "Employee Report"
{
    ApplicationArea = All;
    Caption = 'Employee Report';
    UsageCategory = Administration;
    DefaultLayout = RDLC;
    RDLCLayout = 'EmployeeReport.RDL';

    dataset
    {
        dataitem(CompanyInformation; "Company Information")
        {
            column(Picture; Picture)
            {
            }
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
