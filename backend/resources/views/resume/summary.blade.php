@if(!empty($resume['professional_summary']))

<div class="section">

    <h2>Professional Summary</h2>

    <p style="
        text-align:justify;
        margin-top:8px;
        line-height:1.7;
    ">
        {{ $resume['professional_summary'] }}
    </p>

</div>

@endif