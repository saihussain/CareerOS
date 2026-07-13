<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>CareerOS Resume</title>

    <style>

        body{
            font-family: DejaVu Sans, sans-serif;
            font-size:11px;
            color:#222;
            line-height:1.5;
            margin:28px;
        }

        h2{
            font-size:15px;
            margin-top:18px;
            margin-bottom:8px;
            padding-bottom:4px;
            text-transform:uppercase;
            border-bottom:1px solid #bdbdbd;
        }
        h1{
            mmargin:0;
            font-size:30px;
            font-weight:bold;
            letter-spacing:1px;
        }

        p{
            margin:3px 0;
        }

        .section{
            margin-top:15px;
        }
       
        table{
         width:100%;
         border-collapse:collapse;
        }

        td{
           vertical-align:top;
        }

        a{
             color:#222;
             text-decoration:none;
        }

        .small{
          font-size:10px;
          color:#666;
        }

    </style>

</head>

<body>

@include('resume.header')

@include('resume.summary')

@include('resume.skills')

@include('resume.education')

@include('resume.experience')

@include('resume.projects')

@include('resume.learning')

@include('resume.achievements')

</body>

</html>