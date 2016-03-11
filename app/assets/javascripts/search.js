function search() {
	var state = "";
	if($('select#educationalSubjects :selected').val())
		state += "educationalSubjects_" + $('select#educationalSubjects :selected').val();
	if($('select#selfDeterminationDegree :selected').val())
	{
		if(state != "")
			state += ","; 
		state += "selfDeterminationDegree_" + $('select#selfDeterminationDegree :selected').val();
	}
	if($('select#cognitiveProcess :selected').val())
	{
		if(state != "")
			state += ",";
		state += "cognitiveProcess_" + $('select#cognitiveProcess :selected').val();
	}
	if($('select#knowledge :selected').val())
	{
		if(state != "")
			state += ",";
		state += "knowledge_" + $('select#knowledge :selected').val();
	}
	if($('select#arrangement :selected').val())
	{
		if(state != "")
			state += ",";
		state += "arrangement_" + $('select#arrangement :selected').val();
	}
	if(state == "") state="0";
	jQuery.getJSON('/application/search/' + state, function(data){
        $("#resultList").html(data.content);
    });
    return false;
}
