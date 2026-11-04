<main class="sulmina-journal-post">
    <div class="sulmina-journal-post__content">
        {{ component(
            'blog/blog-post-content', {
                image_lazy: true,
                image_lazy_js: true,
                post_content_classes: {
                    date: 'sulmina-journal-post__date',
                    image: 'sulmina-journal-post__image img-fluid fade-in',
                    content: 'sulmina-journal-post__body',
                },
            })
        }}
    </div>
</main>
