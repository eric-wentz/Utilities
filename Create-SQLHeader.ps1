function Create-SQLHeader ($Header, $explanationString, $HeaderPadding) {
$i=0
$stringAsArray = @()
if ($Header -eq $null -or $explanationString -eq $null){Throw "Either -Header or -explanationString Not Defined when function was called."
break;}
if ($HeaderPadding -eq $null){$HeaderPadding = 20}
$MaxLength = ($Header.length + $HeaderPadding)

$explanationString = "$($explanationString.Trim()) "
$LongestWord = ($explanationString.split(' ') | Measure-Object -Maximum -Property Length).Maximum
$MaxLength = [Math]::Max($MaxLength,$LongestWord+2)
do{  
if($explanationString.length -ge $MaxLength){
$charactersToTake = $explanationString.substring(0,($explanationString.substring(0,$MaxLength)).LastIndexOf(" "))
}
else {$charactersToTake = $explanationString}
 
if($charactersToTake.IndexOf([char]13) -gt 0 ){ 
	$charactersToTake = $charactersToTake.substring(0,$charactersToTake.IndexOf([char]13)+2)
	}
	
$stringAsArray +=  $charactersToTake.trim()
$explanationString = $explanationString.substring($charactersToTake.length )
}
Until ($explanationString.length -eq 0)

"/**$('*'.PadRight($MaxLength,'*'))*/"
"/* $($header.PadRight($MaxLength))*/"
"/* $(' '.PadRight($MaxLength))*/"
$stringAsArray | ForEach-Object { "/* $($_.PadRight($MaxLength))*/" } 
"/* $(' '.PadRight($MaxLength))*/"
"/**$('*'.PadRight($MaxLength,'*'))*/"
}
