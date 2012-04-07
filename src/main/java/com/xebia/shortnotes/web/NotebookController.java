package com.xebia.shortnotes.web;

import com.xebia.shortnotes.domain.Notebook;
import com.xebia.shortnotes.service.NoteService;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RequestMapping("/notebooks")
@Controller
@RooWebScaffold(path = "notebooks", formBackingObject = Notebook.class)
public class NotebookController {
	
	@Autowired
	private NoteService noteService;

	@RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String update(@Valid Notebook notebook, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, notebook);
            return "notebooks/update";
        }
        uiModel.asMap().clear();
        notebookService.updateNotebook(notebook);
        noteService.updateNotesWithNoteBook(notebook);
        return "redirect:/notebooks/" + encodeUrlPathSegment(notebook.getId().toString(), httpServletRequest);
    }
}
