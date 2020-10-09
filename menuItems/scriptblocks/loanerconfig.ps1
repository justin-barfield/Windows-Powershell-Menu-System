function loanerSwitch($loanerConfig){
    switch ($loanerConfig){

        1	#	Loaner setup
            {
                . "$menuItems\loaner\loanerInit.ps1"
            }
        2   #   Presentation Loaner setup
            {
                #Do something
            }
        3   #   Install loaner GPO settings
            {
                loanerGpo
                
            }
        0
            {
                RETURN $Script:loopInitMenu= $false
            }
        default
            {
                Write-Host -BackgroundColor Red -ForegroundColor White "You did not enter a valid sub-menu selection. Please enter a valid selection."
                Start-Sleap -Seconds 3
            }
    }
}