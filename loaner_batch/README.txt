README

These batch files are meant to be used ONLY on designated loaner computers.

Document all changed at bottom!

Follow these steps to initiate:

1. Ensure loaner computer name matches existing naming convention
	a. Convention as of 2/5/20: CL-L-***

2. Create a test .txt document on the desktop
	a. Use this to validate data wipe is working after initialization

3. Right-click on initiate_loaner.bat and run as administrator

4. Wait for computer to reboot and validate:
	a. Data wipe is working
	b. Background image is set
	c. Background image cannot be changed in Personalization settings
	d. Loaner instructions .txt file opens on login

5. Run batch file to remove default Windows 10 apps after reboot.



Computer will be ready for deployment at this time.

Change log:
2/5/20 - username - 	create README file

2-7-20 - username -	Adjustment to process. Uninstall of default Windows apps fails if a Windows update is pending. Powershell will
				need to be run after reboot to finalize process.