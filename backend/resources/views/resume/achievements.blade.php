@if(count($resume['achievements']))

<div class="section">

    <h2>Achievements</h2>

    @foreach($resume['achievements'] as $achievement)

        <div style="margin-bottom:12px;">

            <table width="100%" cellspacing="0" cellpadding="0">

                <tr>

                    <td>

                        <strong>{{ $achievement['title'] }}</strong>

                    </td>

                    <td align="right">

                        {{ date('M Y', strtotime($achievement['date'])) }}

                    </td>

                </tr>

            </table>

            <p>

                {{ $achievement['organization'] }}

            </p>

            @if($achievement['description'])

                <p style="margin-top:5px;text-align:justify;">

                    {{ $achievement['description'] }}

                </p>

            @endif

        </div>

    @endforeach

</div>

@endif