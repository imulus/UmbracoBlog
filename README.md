Umbraco Blog
===========

Finally the definitive simple blog solution for Umbraco.

Details 
----------------------------------------

This package is the beginning of solving a long-term problem that has plagued Umbraco. The lack of a clean, easy to set up, and flexible blog. The Blog Now package is set up to allow blog posts, tags, and custom RSS feeds.

The structure of this package is built into it's own isolated set of document type's and templates. In addition it contains several macros to pull out blog posts and page them properly. It also allows for individual pages of posts to be displayed based on a certain tag. Multiple blogs can be added to a site by simply adding a new blog document type and creating the subpage structure that matches the default install.

Find more information at: http://github.com/imulus/UmbracoBlog 

Configuration Details and Change Log are located below.


Configuration
----------------------------------------
Specify the blog alias name (used for targeting the macros) in the "Page Alias" field on the "Properties" tab of the blog. By default this is set to "blog" and will automatically work.

IMPORTANT: Update the "Related tags" datatype with the proper node ID of the tag folder. This is used to pull in created tags for each blog post.
 

Change Log: 
----------------------------------------
v0.1.2 

- Adding default template so blog works out of the box
- Adding in custom HTML and URL properties for all blogs
- Adding blog name and owner name fields 
- Updating macros to work with tagging on tag specific pages 
- Allowing paging and top count variables (i.e. show only last posts)

v0.1.1 

- Initial checkin of all code, document types, custom icons, build out of base functionality and macros.