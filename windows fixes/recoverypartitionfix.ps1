#What is the WindowsRE Image File?
#WindowsRE Image file, as the name suggests, is the image file for Windows Recovery Environment. 
#This file enables certain options on the PC like reset, system restore, system image recovery, startup repair, etc. 
#If you have been getting the Reagentc.exe WindowsRE Image was not found message, 
#then that means the recovery image has been deleted from the location, or the recovery partition (where the recovery file is) is formatted. 
#
#If you get this error, then that means you won’t be able to recover your PC in case of system failure.
#In case your system goes through some crash, and you need to restore it or perform the startup repair then 
#those options won’t be available for you. Not only this, but even if you try to reset your PC, then you won’t be able to do that either. 
#
#Ways to Fix Reagentc.exe WindowsRE Image Was Not Found
#If you have been getting Reagentc.exe WindowsRE image was not found error message, then you need to get the Windows recovery environment image file and put it back in the location. If the file has been deleted, then you will have to use the Windows Installation media to put it back. Below is the step-by-step process to help you fix this issue-
#
# Install 7-Zip 
#The first step is to download and install 7-Zip on your PC. To do so, follow the steps given below-
#Right-click on the Windows ISO file and then click on Mount to mount the ISO. 
# Extract Windows Recovery Image
#Now the last step is to extract the Windows Recovery image from the mounted ISO file and paste it at the correct location. 
#To do so, follow the steps given below-
#
#Press the Windows key to open the Start Menu. Here, search for 7-Zip File Manager and press Enter to launch it. 
#
#You will see the list of all the partitions; open the mounted partition which has Windows setup files. 
#
#Now, double-click on the Sources folder to open it. 
#
#Double-click on install.esd file to open it. If you don’t find this file then search for install.wim and open it.
#
#You will now see seven folders numbered from 1-7. You will have to open the correct folder depending on the Windows version on your PC. 
#Here’s what folder to open for different Windows versions-
#1- Windows 10/11 Home
#2- Windows 10/11 Home N
#3- Windows 10/11 Home Single Language
#4- Windows 10/11 Education
#5- Windows 10/11 Education N
#6- Windows 10/11 Pro
#7- Windows 10/11 Pro N
#Open the corresponding folder as per the above list. We have Windows 11 Home installed on our PC so we will be opening the folder named 1. 
#Open Folder
#
#Now head to the following location-Windows>System32>Recovery 
Windows>System32>Recovery 
#
#You will see two files here-
#ReAgent.xml
#Winre.wim
#Select both these files, right-click, and click Copy to button from the right-click menu. 
#
#On the pop-up window, click the three dots button, as shown in the image below.
#Select Desktop and then click on OK. 
#Click on the OK button again to copy the files to the desktop. 
#OK
#
#Once done, close the 7-Zip and head to the desktop. 
#Select both the files, i.e., ReAgent.xml and Winre.wim, and copy them. 
ReAgent.xml and Winre.wim
#Copy Files
#
#Open File Explorer by pressing the Windows + E key combo, and head to the following path-C:\Windows\System32\Recovery
C:\Windows\System32\Recovery
#Paste both files in this location. 
#Once done, open the Start Menu, search for Command Prompt, select it, and then click on Ru as Administrator. 
#Now, execute the command given below one-by-one-
#reagentc /enable
reagentc /enable
#reagentc /info
#The command should run without the error and you will see the Windows RE status as Enabled. 
#
#
#
#===========================#
#===========================#



#KB5028997: Instructions to manually resize your partition to install the WinRE update
#Windows 10 Windows 10, version 1607, all editions Windows Server 2016, all editions More...
#Summary
#Microsoft has changed how it updates PCs that run the Windows Recovery Environment (WinRE). WinRE will be updated using the monthly cumulative update. This change only applies to PCs that get updates from Windows Update (WU) and Windows Server Update Services (WSUS). This change starts on June 27, 2023, for the Windows 11, version 22H2 cumulative update.  
#Some PCs might not have a recovery partition that is large enough to complete this update. Because of this, the update for WinRE might fail. You will receive the error message, "Windows Recovery Environment servicing failed.” To help you recover from this failure, this article provides instructions to manually resize your recovery partition if you get a system ErrorPhase of 2. This requires your device to have the recovery partition after the OS partition. Use the steps below to verify this.    
#Manually resize your partition by 250 MB
#Open a Command Prompt window (cmd) as admin.
#To check the WinRE status, run reagentc /info. If the WinRE is installed, there should be a “Windows RE location” with a path to the WinRE directory. An example is, “Windows RE location: [file://%3f/GLOBALROOT/device/harddisk0/partition4/Recovery/WindowsRE]\\?\GLOBALROOT\device\harddisk0\partition4\Recovery\WindowsRE.” Here, the number after “harddisk” and “partition” is the index of the disk and partition WinRE is on.
reagentc /info
#To disable the WinRE, run reagentc /disable
reagentc /disable
#Shrink the OS partition and prepare the disk for a new recovery partition.
#To shrink the OS, run diskpart
diskpart
#Run list disk
list disk
#To select the OS disk, run sel disk<OS disk index>  This should be the same disk index as WinRE.
#To check the partition under the OS disk and find the OS partition, run list part
list part
#To select the OS partition, run sel part<OS partition index>
sel part<OS partition index>
#Run shrink desired=250 minimum=250
shrink desired=250 minimum=250
#To select the WinRE partition, run sel part<WinRE partition index>
sel part<WinRE partition index>
#To delete the WinRE partition, run delete partition override
delete partition override
#Create a new recovery partition.
#First, check if the disk partition style is a GUID Partition Table (GPT) or a Master Boot Record (MBR).  To do that, run list disk. Check if there is an asterisk character (*) in the “Gpt” column.  If there is an asterisk character (*), then the drive is GPT. Otherwise, the drive is MBR.
#If your disk is GPT, run create partition primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac followed by the command gpt attributes =0x8000000000000001
create partition primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac
gpt attributes =0x8000000000000001
#If your disk is MBR, run create partition primary id=27

###create partition primary id=27

#To format the partition, run format quick fs=ntfs label=”Windows RE tools”
format quick fs=ntfs label=”Windows RE tools”
#To confirm that the WinRE partition is created, run list vol
list vol
#To exit from diskpart, run exit
exit
#To re-enable WinRE, run reagentc /enable
reagentc /enable
#To confirm where WinRE is installed, run reagentc /info
reagentc /info
#Note If creation failed or you do not want to extend the WinRE partition, run reagentc /enable to re-enable WinRE.