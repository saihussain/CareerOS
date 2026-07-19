<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">

    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
            font-size: 12px;
            color: #222;
            margin: 30px;
        }

        h1 {
            margin-bottom: 5px;
        }

        h2 {
            margin-top: 22px;
            border-bottom: 1px solid #999;
            padding-bottom: 5px;
        }

        p {
            margin: 4px 0;
        }

        ul {
            margin: 0;
            padding-left: 18px;
        }

        li {
            margin-bottom: 6px;
        }
    </style>
</head>

<body>

<h1>{{ $resume['header']['name'] ?? '' }}</h1>

<p>{{ $resume['header']['email'] ?? '' }}</p>
<p>{{ $resume['header']['phone'] ?? '' }}</p>
<p>{{ $resume['header']['location'] ?? '' }}</p>

@if(!empty($resume['header']['linkedin']))
<p>{{ $resume['header']['linkedin'] }}</p>
@endif

@if(!empty($resume['header']['github']))
<p>{{ $resume['header']['github'] }}</p>
@endif


<h2>Professional Summary</h2>

<p>{{ $resume['summary'] ?? '' }}</p>


<h2>Education</h2>

<ul>
@foreach($resume['education'] ?? [] as $education)
    <li>
        {{ $education['institution'] ?? '' }}
    </li>
@endforeach
</ul>


<h2>Experience</h2>

<ul>
@foreach($resume['experience'] ?? [] as $experience)
    <li>
        {{ $experience['company'] ?? '' }}
    </li>
@endforeach
</ul>


<h2>Skills</h2>

<ul>
@foreach($resume['skills'] ?? [] as $skill)
    <li>
        {{ $skill['name'] ?? '' }}
    </li>
@endforeach
</ul>


<h2>Projects</h2>

<ul>
@foreach($resume['projects'] ?? [] as $project)
    <li>
        {{ $project['title'] ?? '' }}
    </li>
@endforeach
</ul>


<h2>Learning</h2>

<ul>
@foreach($resume['learning'] ?? [] as $learning)
    <li>
        {{ $learning['title'] ?? '' }}
    </li>
@endforeach
</ul>


<h2>Achievements</h2>

<ul>
@foreach($resume['achievements'] ?? [] as $achievement)
    <li>
        {{ $achievement['title'] ?? '' }}
    </li>
@endforeach
</ul>

</body>

</html>