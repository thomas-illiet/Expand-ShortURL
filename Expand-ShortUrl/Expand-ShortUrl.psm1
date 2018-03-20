Function Expand-ShortURL {
    <#  
        .SYNOPSIS  
            Expand Short URLs
        .DESCRIPTION
            Unshortens the short URL using WebRequest
        .PARAMETER Url
            Short URL to be expanded
        .EXAMPLE 
            PS > Expand-ShortURL -URL https://goo.gl/2V2KdA, https://goo.gl/grzdSj

            ShortURL              LongURL
            --------              -------
            https://goo.gl/2V2KdA https://www.thomas-illiet.fr/
            https://goo.gl/grzdSj https://cookbook.thomas-illiet.fr/
    #>
    Param(
            [Parameter(
                Mandatory = $true,
                ValueFromPipeline = $true,
                Position = 0
            )]
            [ValidateNotNullOrEmpty()]
            [string[]] $Url
    )
    Begin{
    }
    Process
    {
        Foreach($Item in $URL){
            try {
                Write-Verbose -Message "$URL - Querying..."
                [PSCustomObject]@{  
                    ShortURL = $Item
                    LongURL = (Invoke-WebRequest -Uri $item -MaximumRedirection 0 -ErrorAction Ignore).Headers.Location
                }
            }
            catch {
                $_.exception.Message
            }
        }
    }
    End{
    }
}