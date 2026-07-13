@if(count($resume['learning']))

<div class="section">

    <h2>Learning</h2>

    @foreach($resume['learning'] as $learning)

        <div style="margin-bottom:12px;">

            <table width="100%" cellspacing="0" cellpadding="0">

                <tr>

                    <td>

                        <strong>{{ $learning['title'] }}</strong>

                    </td>

                    <td align="right">

                        {{ $learning['status'] }}

                    </td>

                </tr>

            </table>

            <p>

                {{ $learning['platform'] }}

                |

                {{ $learning['domain'] }}

            </p>

        </div>

    @endforeach

</div>

@endif