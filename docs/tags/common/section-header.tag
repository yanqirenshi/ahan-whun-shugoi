<section-header>
    <section class="section">
        <div class="container">
            <h1 class="title is-{opts.no ? opts.no : 2}">
                {opts.title}
            </h1>
            <h2 class="subtitle">{opts.subtitle}</h2>

            <yield/>
        </div>
    </section>

    <style>
     section-header > .section {
         background: #23303E;
         margin-bottom: 33px;
     }
     section-header .title, section-header .subtitle {
         color: #ffffff;
     }
    </style>
</section-header>
