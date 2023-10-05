page 50120 "Employee Payment Card"
{
    PageType = Card;
    SourceTable = "Employee payment Header";


    layout
    {
        area(Content)
        {
            group(Details)
            {

                Editable = Editable_released;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }

                field("Starting Date:"; Rec."Starting Date:")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Ending Date:"; Rec."Ending Date:")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }

                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }



                field("Hour Spent"; Rec."Hour Spent")
                {
                    ApplicationArea = all;
                }

                field("Amount Paid"; Rec."Amount Paid")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
            part(Lines; "Employee payment subform")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = field("No.");
                Editable = Editable_released;
            }
            group(Amount)
            {
                field("Total Amount to be paid"; Rec."Total Amount to be paid")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Employee Details")
            {
                promoted = true;
                // PromotedCategory = Process;
                ApplicationArea = All;
                trigger OnAction()
                var
                    E_Pay: Record Employee;
                    epage: Page "Employee Card";

                begin
                    if rec."Employee No." = '' then
                        Error('Please select the employee.')

                    else begin
                        E_Pay.Get(Rec."Employee No.");
                        epage.SetTableView(E_Pay);
                        epage.SetRecord(E_Pay);
                        epage.run();


                    end;
                end;
            }
            action(Released)
            {
                ApplicationArea = All;
                Promoted = true;
                // PromotedCategory = Process;
                Visible = Released_visible;

                trigger OnAction()
                var
                    Rec_setup: Record "Employee Setup";
                    Rec_workFlow: Record "Workflow User Group";
                    Rec_member: Record "Workflow User Group Member";

                begin

                    Rec_setup.Get();
                    Rec_workFlow.SetRange(Code, Rec_setup."Workflow user group");
                    if Rec_workFlow.FindFirst() then begin
                        Rec_member.SetRange("Workflow User Group Code", Rec_workFlow.Code);
                        Rec_member.SetRange("User Name", UserId);
                        if Rec_member.FindFirst() then begin
                            Rec.Status := Rec.Status::Released;
                            Editable_released := false;
                            Rec.Modify(false);
                        end
                        else begin
                            Rec.Status := Rec.Status::"Pending Approval";
                            Editable_released := false;
                            Rec.Modify(true);

                        end;
                    end
                    else begin
                        Error('This action is only available for records with status Draft.');
                    end;
                end;

            }
            action(Approve)
            {
                ApplicationArea = All;
                Promoted = true;
                // PromotedCategory = Process;
                Visible = Approve_visible;

                trigger OnAction()
                var
                    Rec_setup: Record "Employee Setup";
                    Rec_workFlow: Record "Workflow User Group";
                    Rec_member: Record "Workflow User Group Member";

                begin
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        Rec_setup.Get();
                        Rec_workFlow.SetRange(Code, Rec_setup."Workflow user group");
                        if Rec_workFlow.FindFirst() then begin
                            Rec_member.SetRange("Workflow User Group Code", Rec_workFlow.Code);
                            Rec_member.SetRange("User Name", UserId);
                            if not Rec_member.FindFirst() then begin
                                Rec.Status := Rec.Status::Released;
                                Editable_released := false;
                                Rec.Modify(false);
                            end
                            else begin
                                Error('You do not have permission to approve this payment.');
                                //  Rec.Status := Rec.Status::Released;
                            end;
                        end;
                    end
                    else begin
                        Error('This action is only available for records with status Pending Approval.');

                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Promoted = true;
                // PromotedCategory = Process;
                Visible = Reject_visible;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"Pending Approval" then begin
                        Rec.Status := Rec.Status::Draft;
                        Editable_released := true;
                        Rec.Modify(true);
                    end
                    else begin
                        Error('This action is only available for records with status Pending Approval.');
                    end;
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                Promoted = true;
                // PromotedCategory = Process;
                Visible = Reopen_visible;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Released then begin
                        Rec.Status := Rec.Status::Reopen;
                        Editable_released := true;
                        Rec.Modify(true);
                    end
                    else begin
                        Error('This action is only available for records with status ReOpen.');
                    end;
                end;
            }


            // action(delete)
            // {
            //     ApplicationArea = all;
            //     Caption = 'Delete';
            //     promoted = true;
            //     Visible = Delete_visible;

            //     trigger OnAction()
            //     begin
            //         if rec.Status = Rec.Status::Draft then begin
            //             Rec.Delete();
            //         end
            //         else begin
            //             Error('You can not data in this status mode.')
            //         end;

            //     end;
            // }



        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        case
          Rec.Status of
            Rec.Status::Draft:
                begin
                    Editable_released := true;
                    Released_visible := true;
                    Approve_visible := false;
                    Reject_visible := false;
                    Reopen_visible := false;
                    //Delete_visible := true;
                end;
            Rec.Status::Released:
                begin
                    Editable_released := false;
                    Released_visible := false;
                    Approve_visible := false;
                    Reject_visible := false;
                    Reopen_visible := true;
                    //Delete_visible := false;
                end;
            Rec.Status::"Pending Approval":
                begin
                    Editable_released := false;
                    Released_visible := false;
                    Reopen_visible := false;
                    //Delete_visible := false;

                    Rec_setup.Get();
                    Rec_workFlow.SetRange(Code, Rec_setup."Workflow user group");
                    if Rec_workFlow.FindFirst() then begin
                        Rec_member.SetRange("Workflow User Group Code", Rec_workFlow.Code);
                        Rec_member.SetRange("User Name", UserId);
                        if Rec_member.FindFirst() then begin
                            Approve_visible := false;
                            Reject_visible := false;
                        end
                        else begin

                            Approve_visible := true;
                            Reject_visible := true;
                        end;
                    end
                end;
            Rec.Status::Reopen:
                begin
                    Editable_released := true;
                    Released_visible := true;
                    Approve_visible := false;
                    Reject_visible := false;
                    Reopen_visible := true;
                    // Delete_visible := false;
                end;

        end;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        EmpPay_line: Record "Employee Payment Line";
    //Emp_Subform: Page "Employee Payment Subform";
    begin
        if Rec.Status = Rec.Status::Draft then begin
            // Emp_rec.Get();
            EmpPay_line.SetRange("Document No.", Rec."No.");
            if EmpPay_line.FindSet() then begin

                EmpPay_line.DeleteAll();

            end;
            Rec.Delete();
        end
        else begin
            Error('You cannot delete the record at current status');
        end;
    end;


    var
        Editable_released: Boolean;
        Released_visible: Boolean;
        Approve_visible: Boolean;
        Reject_visible: Boolean;
        Reopen_visible: Boolean;

        //Delete_visible: Boolean;

        Rec_setup: Record "Employee Setup";
        Rec_workFlow: Record "Workflow User Group";
        Rec_member: Record "Workflow User Group Member";


}