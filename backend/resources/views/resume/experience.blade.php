@if(count($resume['experience']))

<div class="section">

    <h2>Experience</h2>

    @foreach($resume['experience'] as $experience)

        <div style="margin-bottom:18px;">

            <table width="100%" cellspacing="0" cellpadding="0">

                <tr>

                    <td>

                        <strong>{{ $experience['job_title'] }}</strong>

                    </td>

                    <td align="right">

                        {{ date('M Y', strtotime($experience['start_date'])) }}
                        -

                        @if($experience['currently_working'])
                            Present
                        @else
                            {{ $experience['end_date'] ? date('M Y', strtotime($experience['end_date'])) : '' }}
                        @endif

                    </td>

                </tr>

            </table>

            <p>

                <strong>{{ $experience['company'] }}</strong>

                @if($experience['location'])

                    | {{ $experience['location'] }}

                @endif

            </p>

            @if($experience['description'])

                <p style="margin-top:6px;text-align:justify;">

                    {{ $experience['description'] }}

                </p>

            @endif

        </div>

    @endforeach

</div>

@endif