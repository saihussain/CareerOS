@if(count($resume['projects']))

<div class="section">

    <h2>Projects</h2>

    @foreach($resume['projects'] as $project)

        <div style="margin-bottom:18px;">

            <table width="100%" cellspacing="0" cellpadding="0">

                <tr>

                    <td>

                        <strong>{{ $project['title'] }}</strong>

                    </td>

                    <td align="right">

                        {{ date('M Y', strtotime($project['start_date'])) }}

                    </td>

                </tr>

            </table>

            <p style="margin-top:5px;text-align:justify;">

                {{ $project['description'] }}

            </p>

            <p>

                <strong>Tech Stack:</strong>

                {{ $project['tech_stack'] }}

            </p>

            @if($project['github_url'])

                <p>

                    <strong>GitHub:</strong>

                    {{ $project['github_url'] }}

                </p>

            @endif

            @if($project['live_url'])

                <p>

                    <strong>Live:</strong>

                    {{ $project['live_url'] }}

                </p>

            @endif

        </div>

    @endforeach

</div>

@endif