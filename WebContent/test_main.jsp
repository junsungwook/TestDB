<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
  
    <% 
       request.setCharacterEncoding("utf-8");
       response.setHeader("Cache-Control","no-store");
       response.setHeader("Pragma","no-cache");
       response.setDateHeader("Expires", 0); 
    %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="utf-8">
<title>style test</title>
<script language="JavaScript" type = "text/Javascript">

   var xhrObject;   
   function createXHR(){
      if(window.ActiveXObject){
         xhrObject = new ActiveXObject("Microsoft.XMLHTTP");
      }
      else if (window.XMLHttpRequest){   
         xhrObject = new XMLHttpRequest();
      }
   }
   
   function getData(){
      var form_name = "form_main";
      var user_id = document.forms[form_name].elements["txt_user_id"].value;
      createXHR();
   
      var url = "./testDB.jsp";
      var reqparam = "user_id=" + user_id;
      xhrObject.onreadystatechange = resGetData;
      xhrObject.open("post",url,"true");
      xhrObject.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
      xhrObject.send(reqparam);
   }
   //데이터 testDB로.
   function insertgetData(){
	   var form_name = "form_insert";
	   var uid = document.forms[form_name].elements["id"].value;
	   var uname = document.forms[form_name].elements["name"].value;
	   var uphone = document.forms[form_name].elements["phone"].value;
	   var ugrade = document.forms[form_name].elements["grade"].value;
	  
	      createXHR();
	   
	      var url = "./insertDB.jsp";
	      var reqparam1 ="reqparam1='"+uid+"','"+uname+"','"+uphone+"',"+ugrade;
	      xhrObject.onreadystatechange = resGetData;
	      xhrObject.open("post",url,"true");
	      xhrObject.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");
	      xhrObject.send(reqparam1);
	   		 alert(reqparam1);
   }
   function resGetData(){
       if(xhrObject.readyState == 4){
          if(xhrObject.status == 200){
             var result = xhrObject.responseText;
             var objRes = eval("("+result+")");
             var num = objRes.datas.length;
             var res = "<table cellpadding = '3' cellspacing ='0' border ='1' width='980'>";
             var resDiv = document.getElementById("div_res");
          
             if(num<1){
                res += "<tr><td width = '980' height='100' align ='center' style = 'font-size:50'>검색결과가 없습니다.</td></tr>";
             }
             else{
                for(var i = 0; i<num; i++){
                   var user_id = objRes.datas[i].ID;
                   var user_name = objRes.datas[i].NAME;
                   var user_phone = objRes.datas[i].PHONE;
                   
                   res+="<tr>";
                   res+="<td width = '500' height='100' align ='center' style = 'font-size:20' bgcolor = '#D0E6FC'>"+user_id+"</td>"; 
                   res+="<td width = '500' height='100' align ='center' style = 'font-size:20' bgcolor = '#FFFCC'><br>"+user_name+"</br></td>";               
                   res+="<td width = '500' height='100' align ='center' style = 'font-size:20' bgcolor = '#FFFCC'><br>"+user_phone+"</br></td>";
                   res+="</tr>";
               }
            } 
             res+="</table>";
             resDiv.innerHTML=res;
          }
       }
    }
   function insertData(){
	   var form_name ="form_insert";
	   var uid = document.forms[form_name].elements["id"].value;
	   var uname = document.forms[form_name].elements["name"].value;
	   var uphone = document.forms[form_name].elements["phone"].value;
	   var ugrade = document.forms[form_name].elements["grade"].value;
 
	   alert(uname);
	   if(uid == ""){
           alert("u_id 를 입력해 주세요");
            document.forms[form_name].elements["txt_user_id"].focus();
            return;
        }
        else{
           insertgetData();
        }
   }
    function searchData(){
       var form_name ="form_main";
        var user_id = document.forms[form_name].elements["txt_user_id"].value;
            
        if(user_id == ""){
           alert("u_id 를 입력해 주세요");
            document.forms[form_name].elements["txt_user_id"].focus();
            return;
        }
        else{
           getData();
        }
   }
</script>
</head>
<body>
<div id= 'div_main' width='980' height='300' style = "visibility: visible; position : absolute; left:0px; top:115px; z-index : 1;">
      <table border ='0' width ='980' cellpadding ='0' cellsapcing = '0'>
         <form name="form_insert" >
            <tr>
               <td width='245'>USERID:<input type='text' name ='id' size ='10' ></td>
               <td width='245'>이름:<input type='text' name ='name' size ='10' ></td>
               <td width='245'>전화:<input type='text' name ='phone' size ='10' ></td>       
               <td width='245'>학년:<input type='text' name ='grade' size ='10' ></td>
               <td width='245'>DATE:<input type='text' name ='date' size ='10'   ></td>
               <td width='245'><input type='button' value='입력' size ='10' onClick='javascript:insertData();'></td>
             
            </tr>         
         </form>
      </table>
  <hr>
   <div id= 'div_main' width='980' height='300' style = "visibility: visible; position : absolute; left:0px; top:115px; z-index : 1;">
      <table border ='0' width ='980' cellpadding ='0' cellsapcing = '0'>
         <form name="form_main" onSubmit="javascript:return false;">
            <tr>
               <td width='245'></td>
               <td width='245' align ='right'><input type='text' name ='txt_user_id' size ='10' value ='' maxlength='10' style ='width: 240px; font-size:50; text-align:left;' onkeyup ='javascript:searchData();'></td>
               <td width='245'><img src ='./img/search.png' width ='245' height ='100' onClick ='javascript:searchData();'></td>            
               <td width='245'></td>
            </tr>         
         </form>
      </table>
   </div>
   
   <div id ='div_res' width ='980' style ="visibility:visible; position: absolute; left:0px; top:215px; z-index: 1;">
      <table border ='1' width='980' cellpadding ='10' cellspacing ='0'>
         <tr>
            <td align = 'center' style ='width:950px; font-size:50' bgcolor ='#FFFFCC'>결과물</td>
         </tr>
      </table>
   </div>
</body>
</html>