--  VERSION @SV_VERSION@
--
--    NAME
--      _install.sql
--
--    DESCRIPTION
--      Used to manage the installation of the APEX application and supporting objects
--
--    NOTES
--      Assumes the SYS user is connected.
--
--    Arguments:
--      ^1 = Password for ADMIN user
--      ^2 = script_parse_as_user         
--      ^3 = script_app_id         
--      ^4 = script_mgmt_id         
--
--    MODIFIED   (MM/DD/YYYY)
--      tsthilaire   16-FEB-2014  - Created   
--
--

-- terminate script when an error occurs
WHENEVER SQLERROR EXIT SQL.SQLCODE
--  feedback - Displays the number of records returned by a script ON=1
set feedback off
--  termout - display of output generated by commands in a script that is executed
set termout on
-- serverout - allow dbms_output.put_line to be seen in sqlplus
set serverout on
--  define - Sets the character used to prefix substitution variables
set define '^'
--  concat - Sets the character used to terminate a substitution variable ON=.
set concat on
--  verify off prevents the old/new substitution message
set verify off

def script_pw                  = '^1'
def script_parse_as_user       = '^2'
def script_app_id              = '^3'
def script_mgmt_id             = '^4'
def script_admin_email_address = '^5'

-- START with the workspace
-- manage the workspace details in the workspace script
-- Also Creates ADMIN user 
@@workspace.sql ^script_pw ^script_parse_as_user ^script_admin_email_address

-- Main SERT Application 
@@_install_app.sql apex-sert.sql ^script_app_id

-- SERT Manager Application
@@_install_app.sql apex-sert_admin.sql ^script_mgmt_id

-- SERT Launcher Web Service
@@_install_ws.sql apex-sert_launcher.sql

set define '^'

undef script_pw      
undef script_admin_id
undef script_mgr_id  
undef script_lp_id   

--
-- Note - results of auto application assignment will be 
--        done in the main script at the appropriate time
--
