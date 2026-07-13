@if(count($resume['technical_skills']))

<div class="section">

    <h2>Technical Skills</h2>

    <p>

        @foreach($resume['technical_skills'] as $skill)

            <strong>{{ $skill['name'] }}</strong>

            ({{ $skill['proficiency'] }})

            @if(!$loop->last)
                •
            @endif

        @endforeach

    </p>

</div>

@endif