# Fim
<h3><strong>This is a file integrity monitoring system made on powershell scripting</strong></h3>

If you get error like this:

<p>
PS C:\Users\$(name)\Documents\fim> .\fim.ps1 <br>
.\fim.ps1 : File C:\Users\$(name)\Documents\fim\fim.ps1 cannot be loaded because running scripts is disabled on this <br>
system. For more information, see about_Execution_Policies at https:/go.microsoft.com/fwlink/?LinkID=135170. <br>
At line:1 char:1<br>
+ .\fim.ps1 <br>
+ CategoryInfo          : SecurityError: (:) [], PSSecurityException<br>
+ FullyQualifiedErrorId : UnauthorizedAccess<br>
<br>
<em>
-Start the powershell in administrator mode <br>
-Type in "Set-ExecutionPolicy RemoteSigned" <br>
-Now run the script 
</em>

</p>

First run the file creation.ps1 to create the files required to test the system <br>
