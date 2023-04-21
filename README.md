# HomeList

### Further Improvements
- Talk to backend to change the response of the list to be sorted by type. So the top object has one value for each type, which contains a list of only one type
- The detailed API call should accept a parameter to fetch info for specific item
- Talk to the Design team to create a design system that can be used on all platforms, which will also make the app feel a part of the Hemnet product ecosystem
- Talk to product team of what the upcoming roadmap looks like to develop a plan and identify potential risks and blockers
- One issue with the current solution would be with the ImageDownloader. Since it is using a cache, but never clears it, it could run out of memory. Here it could be a good idea to not have so many images in the cache at the same time.
- Another improvement could be better error handling shown to the users. A discussion with design and product team would be good before deciding on what and when to show errors.
- Some more tests could also be added, mainly on the viewmodels. for example to check the filtering and also parsing of types correctly. 