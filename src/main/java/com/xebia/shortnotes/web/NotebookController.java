package com.xebia.shortnotes.web;

import com.xebia.shortnotes.domain.Notebook;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/notebooks")
@Controller
@RooWebScaffold(path = "notebooks", formBackingObject = Notebook.class)
public class NotebookController {
}
