<page-cmd>
    <section-header title="Command"></section-header>

    <section class="section">
        <div class="container">
            <h1 class="title">Description</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
            </div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Usage</h1>
            <h2 class="subtitle"></h2>
            <div class="contents"></div>
        </div>
    </section>

    <section class="section">
        <div class="container">
            <h1 class="title">Operators</h1>
            <h2 class="subtitle"></h2>
            <div class="contents">
                <operator-list operators={operators}></operator-list>
            </div>
        </div>
    </section>

    <section-footer></section-footer>

    <script>
     this.operators = [
         { package: 'AHAN-WHUN-SHUGOI.CLI', type: 'FUNCTION', name: 'AWS',                    description: '' },
         { package: 'AHAN-WHUN-SHUGOI.DB',  type: 'FUNCTION', name: 'START',                  description: '' },
         { package: 'AHAN-WHUN-SHUGOI.DB',  type: 'FUNCTION', name: 'STOP',                   description: '' },
         { package: 'AHAN-WHUN-SHUGOI.CLI', type: 'FUNCTION', name: '*PRINT-COMMAND-STREAM*', description: '' },
     ];
    </script>
</page-cmd>
