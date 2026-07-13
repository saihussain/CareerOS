@if(count($resume['education']))

<div class="section">

    <h2>Education</h2>

    @foreach($resume['education'] as $education)

        <div style="margin-bottom:15px;">

            <strong>{{ $education['degree'] }}</strong>

            <br>

            {{ $education['institution'] }}

            <br>

            {{ $education['start_year'] }}
            -
            {{ $education['currently_studying'] ? 'Present' : $education['end_year'] }}

            @if($education['cgpa'])

                <br>

                CGPA :
                {{ $education['cgpa'] }}

            @endif

        </div>

    @endforeach

</div>

@endif